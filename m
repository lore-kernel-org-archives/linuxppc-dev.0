Message-ID: <3F8C3F5A.8010700@mvista.com>
Date: Tue, 14 Oct 2003 11:24:26 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Yuxiao Xi <xiyuxiao@harbournetworks.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: question about KGDB for sandpoint with MPC8240
References: <200310141321.IAA20337@lists.linuxppc.org>
In-Reply-To: <200310141321.IAA20337@lists.linuxppc.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yuxiao Xi wrote:

>Hi,
>    Where can I find a KGDB patch to support kernel debugging MontaVista
>2.1 for sandpoint with MPC8240? I selected "CONFIG_KGDB" when do "make
>xconfig",but KGDB seemed not to work. I stole file gen550_kgdb.c and
>gen550_dbg.c from linux-2.6.0, but KGDB seemed not to work yet.
>
>
KGDB was not supported on the sandpoint in mvl2.1.  You can wait for
mvl3.1 or you can patch in the code that in the latest linuxppc (2.4)
public trees.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
