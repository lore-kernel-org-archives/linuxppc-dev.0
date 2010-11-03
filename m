Return-Path: <pat@computer-refuge.org>
Received: from mailhub249.itcs.purdue.edu (mailhub249.itcs.purdue.edu
	[128.210.5.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.purdue.edu",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A4329B70E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  4 Nov 2010 01:43:28 +1100 (EST)
From: Patrick Finnegan <pat@computer-refuge.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: Problem with Infiniband adapter on IBM p550
Date: Wed, 3 Nov 2010 10:43:00 -0400
References: <201010072324.33062.pat@computer-refuge.org>
	<201011022315.04291.pat@computer-refuge.org>
	<20101104003444.5fff5935@kryten>
In-Reply-To: <20101104003444.5fff5935@kryten>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201011031043.00288.pat@computer-refuge.org>
Cc: paulus@samba.org,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, November 03, 2010, Anton Blanchard wrote:
> Firmware has the concept of "super slots" which allow larger memory
> windows and TCE tables. Section 3.4.3 explains it:
> 
> http://www.redbooks.ibm.com/redpapers/pdfs/redp4095.pdf

Aha!  I tried moving the adapter from slot C3 to C5, which is listed in 
that guide, and now it's working.

Thanks for the pointer!

Pat
-- 
Purdue University Research Computing ---  http://www.rcac.purdue.edu/
The Computer Refuge                  ---  http://computer-refuge.org
