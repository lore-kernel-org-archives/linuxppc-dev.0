Message-ID: <38E13171.D5A80E48@embeddededge.com>
Date: Tue, 28 Mar 2000 17:25:53 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: diekema_jon <diekema@bucks.si.com>
CC: linuxppc-embedded@lists.linuxppc.org, all@cideas.com
Subject: Re: Connecting A/D and D/A to SCC channels on a MPC860/MPC8260
References: <m12a0Ki-001SyRC@bucks>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


diekema_jon wrote:
>
>         * I am looking to connect serial A/D's and D/A's to one or more of
>         the MPC860/MPC8260 SCC channels.

Use something that "frames" the data and the SI/TDM interface works
really sweet.  Take a look at the CS4218 audio codec driver I did
for the Embedded Planet boards.  It's floating around in the 2.2.13
kernels on the MontaVista site.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
