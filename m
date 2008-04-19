Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id 90A80DE619
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 04:13:28 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1113481pyg.27
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 11:13:27 -0700 (PDT)
Subject: Re: removal of arch/ppc in 2.6.27?
From: Josh Boyer <jwboyer@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <D713F373-AE2A-4341-9C29-EF65B9399B36@kernel.crashing.org>
References: <D713F373-AE2A-4341-9C29-EF65B9399B36@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 19 Apr 2008 13:13:21 -0500
Message-Id: <1208628801.6654.18.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-04-19 at 10:30 -0500, Kumar Gala wrote:
> This is intended as a reminder that we plan on getting rid of arch/ppc  
> this summer.  I'm guessing based on kernel release times that will be  
> 2.6.27.  That would mean 2.6.26 will be the last kernel to support  
> arch/ppc.
> 
> If people have boards that like ported over please let us know and  
> work with us to port this over to arch/powerpc.
> 
> Here is a list based on arch/ppc/platforms.  Its not intended to be  
> complete but a general idea of what's left in arch/ppc.
> 

<snip>

> OCOTEA          44x

I have one of these.  I'll port it eventually.

josh
