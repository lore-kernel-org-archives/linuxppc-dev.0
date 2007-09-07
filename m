Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1F7BBDDF32
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 05:12:16 +1000 (EST)
Date: Fri, 7 Sep 2007 14:12:34 -0500
From: Olof Johansson <olof@lixom.net>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH v2] powerpc: Add workaround for MPICs with broken
	register reads
Message-ID: <20070907191234.GA6851@lixom.net>
References: <20070905024417.GE27139@lixom.net>
	<20070907092143.GB32102@lixom.net>
	<326829233f0e99b0e0404241f5faaa7a@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <326829233f0e99b0e0404241f5faaa7a@bga.com>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2007 at 09:11:52AM -0500, Milton Miller wrote:

> I'm sorry, I didn't mean to imply it should be asked / selectable, just 
> that the help should be provided.   I won't object to leaving it except 
> that it asks the average user unnecessary questions.   In other words, drop 
> the question after bool.

Sigh. Why is it always that the simple patches/changes require 3 respins? It's
a valid point though, posting v3.


-Olof
