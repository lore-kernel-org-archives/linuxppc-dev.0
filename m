Date: Thu, 23 Nov 2000 13:14:33 +1100
From: Graham Stoney <greyham@research.canon.com.au>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC860-T / FEC transmits each packet 3 times?
Message-ID: <20001123131433.A17577@brixi.research.canon.com.au>
References: <200011222214.eAMMEfO03659@denx.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200011222214.eAMMEfO03659@denx.local.net>; from wd@denx.de on Wed, Nov 22, 2000 at 11:14:41PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Nov 22, 2000 at 11:14:41PM +0100, Wolfgang Denk wrote:
> Any ideas what I am missing?

My best guess is to check your buffer descriptor settings.  Are you setting
the L and W bits in your single BD?  I assume you're polling the BD to
determine when the frame has been sent; are there any errors?  In particular,
is the Retry Count field non-zero?  Is your polling code inadvertently writing
to the BD (rather than just reading it) and setting the R bit again?

Regards,
Graham
--
Graham Stoney
Assistant Technology Manager
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
