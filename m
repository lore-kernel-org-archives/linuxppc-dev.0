Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 30E3F2BDC5
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2004 03:19:11 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0409210852200.9739@localhost.localdomain>
References: <20040921125227.46AE2C108D@atlas.denx.de>
	<Pine.LNX.4.60.0409210852200.9739@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9D3EF712-0BF2-11D9-97DC-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 21 Sep 2004 13:21:03 -0400
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Subject: Re: thoughts and questions on 8xx patches 
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 21, 2004, at 8:56 AM, Robert P. J. Day wrote:

> ok, so i'll back off and ask one more question.

Create and test the patch that works for you.  Don't be creating
options and code for things you can't test and verify.  Those
of us that have lived through the generations of microcode
patches and processor variants know you can't guess what
the future will bring.  If someone else has a need to extend
the work you have done, they will do that to meet their
requirements.

If you make the options available and write the code to
match, people are going to believe it works.  If you can't
test it, they will struggle with it and we will have these
"... this is obviously broken ..." discussions all over again.

Thanks.


	-- Dan
