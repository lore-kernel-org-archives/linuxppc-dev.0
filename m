Message-ID: <39098789.50C297D1@embeddededge.com>
Date: Fri, 28 Apr 2000 08:43:53 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Rodney Davies <rodneyd@nulec.com.au>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Patch for arch/ppc/kernel/head.S - require version update
References: <1072F1A27E99D3119747005004B9A3804157C8@MAIL>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rodney Davies wrote:

> Could anyone please inform me as to where I should be looking.....

The only 2.2.xx kernel that is up to date and regularly maintained
for 8xx processors is 2.2.13 on the MontaVista FTP site.  Look in
the CDK directories.  It has everything for a variety of processor
boards, including all of the Embedded Planet RPX boards.

I am working on bringing this up to at least the 2.2.14 baseline,
and I am talking with Cort about how we maintain 2.2.xx with all of
the exccitement (and time consuming) 2.4.xx and 2.5.xx coming about.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
