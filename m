Message-ID: <20010311231726.8369.qmail@dag.newtech.fi>
To: <linuxppc-dev@lists.linuxppc.org>
Cc: dag@newtech.fi
Subject: rtc-driver
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Mar 2001 01:17:26 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

just ran into a problem with my PPC port
to a VME PreP -like board:

The RTC driver for the 146818 will use a "strange"
setup variable that was wrong for my board:
RTC_ALWAYS_BCD
This was set to one, which effectively made the
driver disregard the real setting in the clock
chip.

Can anyone explain to me why this #define
is there at all ?
The actual value read from the chip should
IMHO be the only thing to consider when reading/
writing the chip... Otherwise you will do as my board did:
read binary data and handle it as BCD, which of course
did the wrong thing...

BRGDS


--
Dag Nygren                               email: dag@newtech.fi
Oy NewTech Ab                            phone: +358 9 8024910
Trasktorpet 3                              fax: +358 9 8024916
02360 ESBO                                 GSM: 0400-426312
FINLAND


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
