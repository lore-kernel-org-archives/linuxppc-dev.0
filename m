Return-Path: <jonmasters@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.192])
	by ozlabs.org (Postfix) with ESMTP id 339D92BDD3
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2004 00:33:51 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 75so597733rnl
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2004 07:33:50 -0700 (PDT)
Message-ID: <35fb2e59041012073325afbcfc@mail.gmail.com>
Date: Tue, 12 Oct 2004 15:33:49 +0100
From: Jon Masters <jonmasters@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <AB928930-1C2D-11D9-925F-000A95A4DC02@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <416709B8.8080107@vision.caltech.edu>
	<4A39EEF2-1B6B-11D9-AE5A-000A95A4DC02@kernel.crashing.org>
	<416B67DE.3050909@nortelnetworks.com>
	<AB928930-1C2D-11D9-925F-000A95A4DC02@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org,
	Arrigo Benedetti <arrigo@bologna.vision.caltech.edu>
Subject: Re: Update frequency of Time Base reg?
Reply-To: jonathan@jonmasters.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 12 Oct 2004 11:04:06 +0200, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> > Look where in which device tree?
> 
> In the "timebase-frequency" property under any CPU node.

so e.g. in /proc/device-tree/cpus/PowerPC,G4/timebase-frequency.

Jon.
