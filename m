Message-ID: <3F182007.8020002@embeddededge.com>
Date: Fri, 18 Jul 2003 12:27:51 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Eli Brin <elib@rokonet.co.il>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8xx SCC's as uart
References: <75DF04AC5ED4D511A9810090273CB4163F5DE5@rokonet-e.rokonet.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eli Brin wrote:

> I have noticed, in kernel 2.4.20, that SCC1 and SCC4 cannot be configured as
> uarts.

Ummmm....2.4.20 from where?

The linuxppc 2.4 development tree was updated by Gary Thomas a while
back to allow all possible SMC/SCC configurations within the resource
limitations of the particular processor variant.  This included the
baud rate generator restrictions on the 857.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
