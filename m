Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 534F62BDAB
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Oct 2004 06:04:56 +1000 (EST)
In-Reply-To: <20041004151259.GC5637@bogon.ms20.nix>
References: <20041004112105.GA5637@bogon.ms20.nix>
	<1096897172.23141.87.camel@gaston>
	<20041004135108.GB5637@bogon.ms20.nix>
	<1096899251.15766.101.camel@gaston>
	<20041004151259.GC5637@bogon.ms20.nix>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A5A9FF28-163F-11D9-B39F-000A95A4DC02@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Mon, 4 Oct 2004 14:57:40 -0500
To: Guido Guenther <agx@sigxcpu.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [agx@sigxcpu.org: [PATCH]: swsusp on linux-2.6.9-rc3]
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Nice. Can you think of a way to monitor calls of MacOS X into the OF?

The video driver is not calling into OF -- OF is long
dead and gone by the time the video driver runs.


Segher
