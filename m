Return-Path: <nhit_bk@yahoo.com>
Message-ID: <20061208150752.69438.qmail@web30009.mail.mud.yahoo.com>
Date: Fri, 8 Dec 2006 07:07:52 -0800 (PST)
From: nam ho <nhit_bk@yahoo.com>
Subject: Can not send and receive data on serial port 2
To: Linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-610065413-1165590472=:68910"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-610065413-1165590472=:68910
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

I have a problem with serial port on TQM8xxL with linux kernel 2.6.11.7. I =
used serial port 1 (ttyCPM0) for console, it ok. But can not send and recei=
ve data on serial port 2 (ttyCPM1) as following echo command:=0A=0A[root@tq=
m_csprj ~]# echo aaaaaaaaaaa > /dev/ttyCPM1.=0A=0AAnd I can see anything ap=
pearing on Hyper Termial. This is a big problem on serial port driver!!!=0A=
=0AAnyone have experimental of serial port driver.=0A=0A=0A=0A=0A=0A=0A=0A=
=0A =0A____________________________________________________________________=
________________=0AHave a burning question?  =0AGo to www.Answers.yahoo.com=
 and get answers from real people who know.
--0-610065413-1165590472=:68910
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:14pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 14pt;"><div style=3D"font-family: times new roman,new york=
,times,serif; font-size: 12pt;"><div style=3D"font-family: times new roman,=
new york,times,serif; font-size: 14pt;"><div>I have a problem with serial p=
ort on TQM8xxL with linux kernel 2.6.11.7. I used serial port 1 (ttyCPM0) f=
or console, it ok. But can not send and receive data on serial port 2 (ttyC=
PM1) as following echo command:<br><br>[root@tqm_csprj ~]# echo aaaaaaaaaaa=
 &gt; /dev/ttyCPM1.<br><br>And I can see anything appearing on Hyper Termia=
l. This is a big problem on serial port driver!!!<br><br>Anyone have experi=
mental of serial port driver.<br></div></div></div><br></div></div><br>=0A=
=0A<hr size=3D1>Want to start your own business? Learn how on <a href=3D"ht=
tp://us.rd.yahoo.com/evt=3D41244/*http://smallbusiness.yahoo.com/r-index">Y=
ahoo! Small Business.</a></body></html>
--0-610065413-1165590472=:68910--
