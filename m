Message-ID: <3C87B6C8.9070905@cymes.de>
Date: Thu, 07 Mar 2002 19:51:52 +0100
From: Matthias Grimm <joker@cymes.de>
MIME-Version: 1.0
To: PPC-Dev Mailingliste <linuxppc-dev@lists.linuxppc.org>
Subject: pbbuttons, need some help
References: <3C852E12.3030300@cymes.de> <20020306090814.15511@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everybody,

I wrote the program PBButtons <http://www.cymes.de/members/joker/> and
need your help for a special task.

I would ask for someone who could assist me with debugging some code on
an OHARE-based Powerbook? I teached pbbuttonsd to read battery
information but I could only test the part depending on
PMU_SMART_BATTERY_STATE because I have no OHARE-based Powerbook at hand.
I took the part depending on PMU_BATTERY_STATE from the kernel source
but I would like to verify it again before I release it to the public.

I would also be confident with some valid data sets the PMU returned on
PMU_BATERY_STATE, so I could simulate a OHARE-based Powerbook.

If anyone have some documentation he would be welcome to send me a copy

   Regards
     Matthias Grimm


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
