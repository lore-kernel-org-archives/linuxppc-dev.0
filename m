Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20080815013439.GB12327@yookeroo.seuss>
References: <Pine.LNX.4.64.0808140827220.2701@blarg.am.freescale.net>
	<20080814174348.GA19488@ld0162-tx32.am.freescale.net>
	<20080815013439.GB12327@yookeroo.seuss>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B8AE3E9F-3F7A-4533-8C6C-1C6E2F45044A@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3] libfdt: Add support for using aliases in
	fdt_path_offset()
Date: Sat, 16 Aug 2008 08:51:06 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hmm.. my reading of 1275 says that an alias pointing to another alias
> is not permitted, but I'm not terribly confident I'm not misreading
> it.  Segher, do you know whether this is allowed?

My reading is the same: if after expanding an alias the path does
not start with "/", the search starts at the current package,
otherwise it starts at the root node; and no further alias expansion
is done.

It's a corner case for sure, but at least the standard doesn't
require us to implement recursive alias expansion; let's see if
common practice does ;-)


Segher
