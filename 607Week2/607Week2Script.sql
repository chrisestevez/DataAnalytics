drop schema if exists 607Week2;

CREATE SCHEMA 607Week2 ;
USE 607Week2;

DROP TABLE IF EXISTS MovieInfo;
DROP TABLE IF EXISTS UserInfo;
DROP TABLE IF EXISTS 607Week2.TMovieReview;

CREATE TABLE 607Week2.MovieInfo (
  MovieInfoID INT not null AUTO_INCREMENT,
  MovieName varchar(125) not null, 
  PRIMARY KEY (MovieInfoID));
  
  
   INSERT INTO MovieInfo(MovieName) VALUES ('Sully');
   INSERT INTO MovieInfo(MovieName) VALUES ('When the Bough Breaks');
   INSERT INTO MovieInfo(MovieName) VALUES ('The Disappointments Room');
   INSERT INTO MovieInfo(MovieName) VALUES ('The Wild Life');
   INSERT INTO MovieInfo(MovieName) VALUES ('Author: The JT LeRoy Story');
      INSERT INTO MovieInfo(MovieName) VALUES ('Other People');
   
   CREATE TABLE 607Week2.UserInfo (
  UserInfoID INT not null AUTO_INCREMENT,
  UserName varchar(125) not null, 
  UserSex varchar(1) not null,
  PRIMARY KEY (UserInfoID));
  
    INSERT INTO UserInfo(UserName,UserSex) VALUES ('Noah','M');
    INSERT INTO UserInfo(UserName,UserSex) VALUES ('Liam','M');
    INSERT INTO UserInfo(UserName,UserSex) VALUES ('Mason','M');
    INSERT INTO UserInfo(UserName,UserSex) VALUES ('Emma','F');
    INSERT INTO UserInfo(UserName,UserSex) VALUES ('Sophia','F');
    
    
  CREATE TABLE 607Week2.TMovieReview (
  TMovieInfoID INT not null,
  TUserInfoID INT not null, 
  TUserRating int(1),
  FOREIGN KEY TMovieReview(TMovieInfoID) REFERENCES MovieInfo(MovieInfoID),
  FOREIGN KEY TMovieReview(TUserInfoID) REFERENCES UserInfo(UserInfoID),
  PRIMARY KEY (TMovieInfoID,TUserInfoID));  
    
     INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (1,1,5);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (1,2,5);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (1,3,5);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (1,4,4);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (1,5,4);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (2,1,5);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (2,2,2);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (2,3,4);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (2,4,5);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (2,5,5);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (3,1,2);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (3,2,2);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (3,3,3);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (3,4,3);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (3,5,2);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (4,1,3);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (4,2,4);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (4,3,1);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (4,4,1);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (4,5,2);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (5,1,1);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (5,2,3);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (5,3,4);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (5,4,4);
    INSERT INTO TMovieReview(TMovieInfoID,TUserInfoID,TUserRating) VALUES (5,5,5);
   
   
   select userinfo.userName, userinfo.usersex, movieinfo.MovieName,Tmoviereview.TUserRating
   from userinfo left join tmoviereview 
   on UserInfoID = TUserInfoID
   left join movieinfo
   on TMovieInfoID = MovieInfoID;
    