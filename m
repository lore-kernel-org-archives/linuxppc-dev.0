Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <1192514497.19073.29.camel@pasglop>
References: <20071016050217.GA9052@localhost.localdomain>
	<B17BEF48-34FC-44E0-AC23-1DB7522EB198@kernel.crashing.org>
	<18196.20112.728499.256646@cargo.ozlabs.ibm.com>
	<5E3B6FCC-5930-4C76-AB4B-86B35551B9E0@kernel.crashing.org>
	<1192514497.19073.29.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C7CB7F1C-1EE4-4E51-9E62-5375FBC1822C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Merge dtc
Date: Tue, 16 Oct 2007 01:23:59 -0500
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 16, 2007, at 1:01 AM, Benjamin Herrenschmidt wrote:

>
> On Tue, 2007-10-16 at 00:50 -0500, Kumar Gala wrote:
>> Just out of interest who's complaining?  We don't include mkimage
>> for
>> u-boot related builds and I haven't seen any gripes related to that.
>
> It's a pain in the neck since those are built even for things that  
> don't
> need them (such as 4xx where I use the treeboot images).

That was Paul's decision :)

- k
