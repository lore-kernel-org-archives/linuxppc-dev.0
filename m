Subject: Re: 604r
Date: Sat, 29 Jan 2000 20:00:39 -0800
From: Grant Erickson <erick205@tc.umn.edu>
To: " Geert Uytterhoeven" <geert@linux-m68k.org>
cc: <linuxppc-dev-digest@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Message-Id: <iss.2e3c.3893b720.670a9.1@mhub2.tc.umn.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 28 Jan 2000 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>Suddenly my CPU type changed with 2.3.41 from `604e rev 18.3' to `604r rev
>2.3'. Is this OK?

Geert,

I checked in a change to get_cpuinfo() in arch/ppc/kernel/setup.c which
made the CPU types and revision numbers reported more consistent with
documents published by Motorola and IBM as to the correlation between
PVRs and particular processor names.

I don't have said documents accessible from the machine on which I'm
typing this; however, I can e-mail them to you on Monday if you'd like.

Regards,

Grant

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
