Message-ID: <3E5E584E.2020703@acm.org>
Date: Thu, 27 Feb 2003 13:26:22 -0500
From: "Michael R. Zucca" <mrz5149@acm.org>
MIME-Version: 1.0
To: David Bryan <Dave@ThePTRGroup.com>
Cc: Rudy Klinksiek <klink@arlut.utexas.edu>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: "Illegal instruction" traps on smp clients - 2.4.19
References: <NEBBLKDMGLOGOAOIDAIDOELPEHAA.Dave@ThePTRGroup.com>
In-Reply-To: <NEBBLKDMGLOGOAOIDAIDOELPEHAA.Dave@ThePTRGroup.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Bryan wrote:
 > These modes are controlled by two bits in
> the Memory subsystem control register (MSSCR0).  At reset, the MSSCR0
> defaults to MEI mode with the SHD signal disabled.  By placing the 7400 in
> MESI mode at boot, we solved the problem.

Would you care to share what MSSCR0 bits these were and what you set
them to? :-)

--
----------------------------------------------
  Michael Zucca - mrz5149@acm.org
----------------------------------------------
  "I'm too old to use Emacs." -- Rod MacDonald
----------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
