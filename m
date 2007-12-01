Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 1974FDDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Dec 2007 17:39:38 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so496402anc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Nov 2007 22:39:38 -0800 (PST)
Message-ID: <fa686aa40711302239u56a264ddyaaad454bc00bb4dd@mail.gmail.com>
Date: Fri, 30 Nov 2007 23:39:37 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: current ARCH=powerpc for v2pro.
In-Reply-To: <20071130222205.73E79A68013@mail72-blu.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071130222205.73E79A68013@mail72-blu.bigfish.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/30/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
>
> Grant,
>
> I'm trying to bring up your arch/powerpc work, using a compiled in
> device tree.  I added this:
>
<snip>
>
> Which seems bizarre, because that code is very simple.  I'm guessing
> that something in the memory configuration is wierd (or maybe
> zImage.virtex is not the right way to do this?) but I'm a little lost
> where to look from here.  I also tried it with both paulus_master and
> your virtex-for-2.6.24 branch.


I've got a patch that adds 'raw' image support (originally written by
Scott Wood) which somewhat works for booting (but not entirely; I
haven't had time to dig into it properly yet).  It's not suitable to
go into mainline yet.  I'll try to get the patch out to my tree this
evening... actually I've been trying to get my tree pushed out all
today, but other things keep coming up.  :-)

<several hours after I wrote the above>

Okay, I pushed my current patch set out to the master branch of my
linux-2.6-virtex tree.  Give it a whirl.  It's not perfect, but it
should be usable for booting.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
