Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20080708042631.GB7328@yookeroo.seuss>
References: <20080708042631.GB7328@yookeroo.seuss>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4ca5bd814ebc5d76508d40503f4884db@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Mikrotik RouterBoard 333
Date: Tue, 15 Jul 2008 02:17:36 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Its firmware apparently provides a flattened device tree to the OS.
> And while this step towards world domination is flattering, it's an
> example of what I feared when people first got enthusiastic about the
> idea of including flattened device trees in firmwares.  The tree has
> not, AFAIK, been past this list, and has apparently not been reviewed
> by someone knowledgeable about device trees.  In short, it's crap, and
> now that it's embedded in the firware we can't really fix it.

Can't you build a kernel with a blob that overrides the 
firmware-provided
blob?


Segher
