Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id AEE142C01FC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 09:50:27 +1000 (EST)
Message-ID: <1373413824.7458.38.camel@gandalf.local.home>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Emulate MCSRR0/1 SPR and rfmci
 instruction
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexander Graf <agraf@suse.de>
Date: Tue, 09 Jul 2013 19:50:24 -0400
In-Reply-To: <B31BC4F4-39E8-479D-B5AB-2D7F870E7A6C@suse.de>
References: <1372858255-19708-1-git-send-email-mihai.caraman@freescale.com>
 <1372858255-19708-2-git-send-email-mihai.caraman@freescale.com>
 <1C2B7183-EF0F-4D97-9287-1068C9E97471@suse.de> <1373390162.8183.195@snotra>
 <51DC4C78.5080808@suse.de> <1373394562.8183.197@snotra>
 <822D94B1-6E7E-4416-9F34-72E3BEAF6B8F@suse.de> <1373406891.8183.207@snotra>
 <B31BC4F4-39E8-479D-B5AB-2D7F870E7A6C@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 "<kvm@vger.kernel.org> list" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-07-10 at 00:00 +0200, Alexander Graf wrote:

> Then don't overflow the buffer. Make it large enough. IIRC ftrace improved recently to dynamically increase the buffer size too.
> 
> Steven, do I remember correctly here?

Not really. Ftrace only dynamically increases the buffer when the trace
is first used. Other than that, the size is static. I also wouldn't
suggest allocating the buffer when needed as that has the overhead of
allocating memory.

-- Steve
