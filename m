Message-ID: <3DBF0764.10808@intrex.net>
Date: Tue, 29 Oct 2002 17:10:44 -0500
From: Ralph Blach <rblach@intrex.net>
MIME-Version: 1.0
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: DBCR0 reset?
References: <1035919100.1013.1226.camel@granite.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hollis,

The OS does this.  I send you the info on how to disable it tommorrow.

Chip

Hollis Blanchard wrote:
> Has anyone had problems with hardware breakpoints from external
> debuggers? I'm using RISCWatch, which sets DBCR0 and IAC1 for me (yes
> I've verified that). I'm then using 'echo > /proc/sys' to invoke my
> code. However by the time I get to my sysctl proc handler, DBCR0 has
> been reset from 0x80810000 to 0x00010000, hence IAC1 is ignored.
>
> I don't see much use of DBCR0, other than initialization and then save
> during exception prologs and then restore during task restore. Can
> anyone point me to where it might be reset?
>
> -Hollis
>
>
>
> .
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
