From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>,
        Daniel Eisenbud
 <eisenbud@cs.swarthmore.edu>,
        Paul Mackerras <paulus@linuxcare.com>
Subject: Re: SOLVED: mesh SCSI bus locks hard on 7500 when burning a CD-R in
 dao mode
Date: Mon, 5 Feb 2001 13:41:56 +0100
Message-Id: <19341231061340.4623@mailhost.mipsys.com>
In-Reply-To: 
 <Pine.LNX.4.30.0102021043380.15482-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.30.0102021043380.15482-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>The SCSI specs are probably the authoritative guide here. Plus the MESH
>and 53C94 data sheets.

I would add to this list Apple's Darwin MESH driver source that describe
with comments various MESH HW bugs and usual SCSI devices bugs that
confuse MESH, along with workarounds.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
