Message-ID: <3C599004.7010104@embeddededge.com>
Date: Thu, 31 Jan 2002 13:42:12 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Mark Pilon <mpilon@midrivers.com>
Cc: Armin Kuster <akuster@mvista.com>,
	"David =?ISO-8859-1?Q?M=FCller?= (  ELSOFT AG)" <d.mueller@elsoft.ch>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] 3 patches against linuxppc_dev-2.4.18-pre7
References: <3C57F9AC.9040008@elsoft.ch> <3C58410B.802BC1F4@mvista.com> <3C59005A.4080400@elsoft.ch> <3C5989D2.3F77685@mvista.com> <3C598C41.8AC31B3C@midrivers.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Pilon wrote:

> You might check the actual code generated for ffs() and verify
> it works -- I ended up recoding this routine because ffs() wasn't
> working correctly ... [ I forget the particulars, but the code
> generated and behavior were not correct ];

It would be nice if you posted the particulars.  This function is
used in a variety of places, and it appears to work just fine.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
