Subject: Re: Riscwatch Probe
To: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF602712C4.C8A0E6C9-ON87256C59.00432EAF@boulder.ibm.com>
From: "Ralph Blach" <rcblach@us.ibm.com>
Date: Mon, 21 Oct 2002 08:15:40 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kenneth,

Try compiling with -dwarf2.  We have no problem with symbolic debug    with
riscwatch here.

You will also need to set you srchpath to inclulde the .o file that contain
the debug info

Chip

Kenneth Johansson <kenneth.johansson@etx.ericsson.se>@lists.linuxppc.org on
10/21/2002 03:38:47 AM

Sent by:    owner-linuxppc-embedded@lists.linuxppc.org


To:    Aman <aman@mistralsoftware.com>
cc:    Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject:    Re: Riscwatch Probe




On Sat, 2002-10-19 at 20:48, Aman wrote:
>
> Hi All
>
> Can we use Riscwatcg Probe from IBM to debug PPCboot code.
>

yes and no. I could never get riscwatch software to do symbolic
debugging.

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
