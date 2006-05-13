Return-Path: <joachim.denil@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id C926E679E9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 May 2006 23:17:23 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so475482ugf
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 May 2006 06:17:21 -0700 (PDT)
Message-ID: <d7b8e9f80605130610v7e0fa0ffx64641c63c4487dfe@mail.gmail.com>
Date: Sat, 13 May 2006 15:10:45 +0200
From: "Joachim Denil" <joachim.denil@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: board without RTC
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_34177_13288435.1147525845092"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_34177_13288435.1147525845092
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

Can someone tell me what the following functions should do in case there is
no RTC on the hardware board. My processor is a 405gpr. Which of these i
must implement. (maybe some code snippets...). I think the most important
one is calibrate_decr for it is necesary to calibrate_delay function.

Thanks...

Joachim Denil
Student


long (*time_init <http://lxr.linux.no/ident?a=3Dppc;i=3Dtime_init>)(void);
int (*set_rtc_time <http://lxr.linux.no/ident?a=3Dppc;i=3Dset_rtc_time>)(un=
signed
long nowtime);
unsigned long (*get_rtc_time<http://lxr.linux.no/ident?a=3Dppc;i=3Dget_rtc_=
time>
)(void);
unsigned char (*rtc_read_val)(int addr<http://lxr.linux.no/ident?a=3Dppc;i=
=3Daddr>
);
void (*rtc_write_val)(int addr <http://lxr.linux.no/ident?a=3Dppc;i=3Daddr>=
,
unsigned char val <http://lxr.linux.no/ident?a=3Dppc;i=3Dval>);
void (*calibrate_decr)(void);

------=_Part_34177_13288435.1147525845092
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hello,</div>
<div>&nbsp;</div>
<div>Can someone tell me what the following functions should do in case the=
re is no RTC on the hardware board. My processor is a 405gpr. Which of thes=
e i must implement. (maybe some code snippets...). I think the most importa=
nt one is calibrate_decr for it is necesary to calibrate_delay function.
</div>
<div>&nbsp;</div>
<div>Thanks...</div>
<div>&nbsp;</div>
<div>Joachim Denil</div>
<div>Student</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>long&nbsp;(*<a href=3D"http://lxr.linux.no/ident?a=3Dppc;i=3Dtime_init=
">time_init</a>)(void);&nbsp;</div>
<div>int&nbsp;(*<a href=3D"http://lxr.linux.no/ident?a=3Dppc;i=3Dset_rtc_ti=
me">set_rtc_time</a>)(unsigned long nowtime);<br>unsigned long&nbsp;(*<a hr=
ef=3D"http://lxr.linux.no/ident?a=3Dppc;i=3Dget_rtc_time">get_rtc_time</a>)=
(void);<br>unsigned char&nbsp;(*rtc_read_val)(int=20
<a href=3D"http://lxr.linux.no/ident?a=3Dppc;i=3Daddr">addr</a>);<br>void (=
*rtc_write_val)(int <a href=3D"http://lxr.linux.no/ident?a=3Dppc;i=3Daddr">=
addr</a>, unsigned char <a href=3D"http://lxr.linux.no/ident?a=3Dppc;i=3Dva=
l">val</a>);<br>
void&nbsp;(*calibrate_decr)(void);<br>&nbsp;</div>

------=_Part_34177_13288435.1147525845092--
