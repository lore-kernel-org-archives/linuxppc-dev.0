Message-ID: <3CDBFFC9.205DB0A5@synergymicro.com>
Date: Fri, 10 May 2002 10:13:46 -0700
From: Bill Fincke <willy@synergymicro.com>
Reply-To: willy@synergymicro.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: "broken" GT64260 ethernet driver
References: <200205100459.XAA27925@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have ported the gt64260_eth.c driver (from the MontaVista BK
tree) to our board. The only modifications made were for our MAC
address setup and interrupt connections. I have run all 3 ports
under 2.4.12-SMP and have not yet seen a problem, but I haven't
done anything too stressful.

But there have been a lot of "this driver is broken" comments
on the thread. I agree it's ugly, but it seems to work. Can
someone elaborate on exactly what is "broken", so I can test
it more thoroughly?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
