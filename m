Return-Path: <sombat3960@gmail.com>
MIME-Version: 1.0
From: Sombat Tragolgosol <sombat3960@gmail.com>
Date: Mon, 26 Jun 2017 16:26:50 +0700
Message-ID: <CAC1vu63d9t3vdfz_+62hDc94tfG=rRN757RezXh8wSNwnYdmZg@mail.gmail.com>
Subject: ps3 linux: os_area_queue_work_handler: Could not update FLASH ROM
To: Linuxppc-dev@lists.ozlabs.org
Cc: geoff@infradead.org, Jeremy Kerr <jk@ozlabs.org>
Content-Type: multipart/alternative; boundary="f403043eee34ffd7e70552d98c21"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f403043eee34ffd7e70552d98c21
Content-Type: text/plain; charset="UTF-8"

Dear Sir,

I'd like to have help and ask some.

1) Is it normal for os_area_queue_work_handler: Could not update FLASH ROM?
2) My Date time is not correct.  Is the problem is not able to update
os-area data?

Here below is my rtc time problem.

RTC time is not proper value (lower than it should be).
(For GameOS , Date-Time is OK.)

Here is what I've tried
   1) lv1_get_rtc gets 205943663 (11 Jul 1976)
   2) saved_params.rtc_diff always is 946684800
        (205943663+946684800) = 11 Jul 2006
   So every time, my Linux is booted,  my year says 2006 and causes problem
on clock skew.
   3) if I add 345746286 to rtc in read_rtc function in
      arch/powerpc/platforms/ps3/time.c and
      drivers/rtc/rtc-ps3.c
      (205943663+946684800+345746286) = 25 Jun 2017
   My boot time and date is acceptable for my temporary use.

   Do you have any proper solution? I don't want to modify source for my
one rtc time problem?

Best regards,
Sombat T.

--f403043eee34ffd7e70552d98c21
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div>Dear Sir,<br></div><div><br>=
I&#39;d like to have help and ask some. <br><br>1) Is it normal for os_area=
_queue_work_handler: Could not update FLASH ROM?<br></div><div>2) My Date t=
ime is not correct.=C2=A0 Is the problem is not able to update os-area data=
?<br><br>Here below is my rtc time problem.<br><br>RTC time is not proper v=
alue (lower than it should be).<br>(For GameOS , Date-Time is OK.)<br><br>H=
ere is what I&#39;ve tried <br>=C2=A0=C2=A0 1) lv1_get_rtc gets 205943663 (=
11 Jul 1976)<br>=C2=A0=C2=A0 2) saved_params.rtc_diff always is 946684800<b=
r></div><div>=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 (205943663+946684800) =3D 11 =
Jul 2006<br></div>=C2=A0=C2=A0 So every time, my Linux is booted,=C2=A0 my =
year says 2006 and causes problem on clock skew.<br></div>=C2=A0=C2=A0 3) i=
f I add 345746286 to rtc in read_rtc function in</div>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 arch/powerpc/platforms/ps3/time.c and<br></div>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 drivers/rtc/rtc-ps3.c<br></div><div>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (205943663+946684800+345746286) =3D 25 Jun 2017<br></div><div></div>=
=C2=A0=C2=A0 My boot time and date is acceptable for my temporary use.<br><=
/div><div><br>=C2=A0=C2=A0 Do you have any proper solution? I don&#39;t wan=
t to modify source for my one rtc time problem?<br><br></div><div>Best rega=
rds,<br></div><div>Sombat T.<br><br></div>=C2=A0=C2=A0 <br><div><div><br></=
div></div></div>

--f403043eee34ffd7e70552d98c21--
