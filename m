Message-ID: <3C03CCD9.9040004@humboldt.co.uk>
Date: Tue, 27 Nov 2001 17:26:49 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: VT82C686B IDE and Linux/PPC woes
References: <0111271710.AA24459@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:

 > Adrian Cox <adrian@humboldt.co.uk> wrote:


 >> Could there be something wrong with your ppc_ide_md.ide_init_hwif
 >> function?

 > Aha, I didn't have one. I wrote one:

You're probably lacking the other IDE setup functions as well, then.
Take a look at the sandpoint code as an example.

--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
