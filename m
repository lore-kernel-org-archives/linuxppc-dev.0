Message-ID: <3AE859E4.8CF5063A@mvista.com>
Date: Thu, 26 Apr 2001 13:24:52 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: John Traill <john.traill@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 SCC as Console
References: <3AE82655.DADBB0B2@motorola.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John Traill wrote:
>
> Does anyone have a patch ( Or is working on one ) to use an SCC as a console ?

Yes.  The linuxppc_2_5 kernel has all of the right pieces.  I have
since made some changes that allow this to be selected as a configuration
option, and the patches are in the pipeline back to the FSM Labs trees.

When using the SCC Console, the driver doesn't support SMC serial
ports due to some configuration conflicts I haven't yet resolved.
So far, I haven't seen hardware that uses an SCC console and SMC serial
ports, which places fixing this rather low on my list.

What board are you working on?  I have a Linux port for the ADS8260.....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
