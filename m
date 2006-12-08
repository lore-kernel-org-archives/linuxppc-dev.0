Return-Path: <nhit_bk@yahoo.com>
Received: from web30002.mail.mud.yahoo.com (web30002.mail.mud.yahoo.com
	[209.191.69.19]) by ozlabs.org (Postfix) with SMTP id 25A6D67BD9
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Dec 2006 02:02:52 +1100 (EST)
Message-ID: <20061208150250.17847.qmail@web30002.mail.mud.yahoo.com>
Date: Fri, 8 Dec 2006 07:02:50 -0800 (PST)
From: nam ho <nhit_bk@yahoo.com>
Subject: Can not send and receive data on serial port 2
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-761204869-1165590170=:17511"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-761204869-1165590170=:17511
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

I have a problem with serial port on TQM8xxL with linux kernel 2.6.11.7. I =
used serial port 1 (ttyCPM0) for console, it ok. But can not send and recei=
ve data on serial port 2 (ttyCPM1) as following echo command:=0A=0A[root@tq=
m_csprj ~]# echo aaaaaaaaaaa > /dev/ttyCPM1.=0A=0AAnd I can see anything ap=
pearing on Hyper Termial. This is a big problem on serial port driver!!!=0A=
=0AAnyone have experimental of serial port driver.=0A=0A=0A=0A=0A =0A______=
___________________________________________________________________________=
___=0ADo you Yahoo!?=0AEveryone is raving about the all-new Yahoo! Mail bet=
a.=0Ahttp://new.mail.yahoo.com
--0-761204869-1165590170=:17511
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:14pt"><div>I have a problem with serial port on TQM8xxL with linu=
x kernel 2.6.11.7. I used serial port 1 (ttyCPM0) for console, it ok. But c=
an not send and receive data on serial port 2 (ttyCPM1) as following echo c=
ommand:<br><br>[root@tqm_csprj ~]# echo aaaaaaaaaaa &gt; /dev/ttyCPM1.<br><=
br>And I can see anything appearing on Hyper Termial. This is a big problem=
 on serial port driver!!!<br><br>Anyone have experimental of serial port dr=
iver.<br></div></div><br>=0A=0A<hr size=3D1>Any questions?  Get answers on =
any topic at <a href=3D"http://answers.yahoo.com/;_ylc=3DX3oDMTFvbGNhMGE3BF=
9TAzM5NjU0NTEwOARfcwMzOTY1NDUxMDMEc2VjA21haWxfdGFnbGluZQRzbGsDbWFpbF90YWcx"=
>Yahoo! Answers</a>. Try it now.</body></html>
--0-761204869-1165590170=:17511--
