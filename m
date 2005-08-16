Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id B556267F5C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Aug 2005 15:25:13 +1000 (EST)
Date: Mon, 15 Aug 2005 22:25:10 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Otto Solares <solca@guug.org>
Message-ID: <20050815222510.C28706@cox.net>
References: <20050812032819.GA4763@guug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050812032819.GA4763@guug.org>;
	from solca@guug.org on Thu, Aug 11, 2005 at 09:28:19PM -0600
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Redwood-6 and 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2005 at 09:28:19PM -0600, Otto Solares wrote:
> Hi!
> 
> Redwood-6 support in 2.6 is broken.  I subscribed to this
> list just to know if somebody is working on it?  2.4.30
> works ok.

I went ahead and fixed this compile issue in the following patch:
http://ozlabs.org/pipermail/linuxppc-embedded/2005-August/019782.html

-Matt
