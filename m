Message-ID: <63637.213.107.143.228.1047755590.squirrel@www.solinno.co.uk>
Date: Sat, 15 Mar 2003 19:13:10 -0000 (GMT)
Subject: Re: Escala & linux
From: "Leigh Brown" <leigh@solinno.co.uk>
To: <WHarms@bfs.de>
In-Reply-To: <vines.sxdD+WPoQyA@SZKOM.BFS.DE>
References: <vines.sxdD+WPoQyA@SZKOM.BFS.DE>
Cc: <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Walter Harms said:
> a PPC-based Bull Escala is going into retirement here.
> any change getting linux running on that beast ?

Possibly.  What sort of machine is it?  Can you run some commands under
AIX?  If so, send the output from the following commands:

1. bootinfo -p                # Displays the architecture
2. lscfg                      # Displays the hardware configuration
3. lsattr -El proc0           # Displays the CPU type
4. lsattr -El sys0 -a modelname,frequency,fwversion,realmem

Cheers,

Leigh.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
