Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <fa686aa40808060631k278e187ej965f0ac08c837937@mail.gmail.com>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060239.30717.79273.stgit@trillian.secretlab.ca>
	<20080805.233205.201125898.davem@davemloft.net>
	<18585.31504.836857.829592@cargo.ozlabs.ibm.com>
	<fa686aa40808060631k278e187ej965f0ac08c837937@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C5C0AA60-C45F-4467-AC76-AA24A00CA4AC@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
Date: Wed, 6 Aug 2008 18:25:48 +0200
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	David Miller <davem@davemloft.net>, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> It's not what we do with flattened device trees blobs though.  In the
> flattened tree we're not using a /chosen/stdout property, just the
> linux,stdout-path one.
>
> The question that remains is; should there be?  Should the dt blobs
> use /chosen/stdout also?  (I'm not familiar enough with real OF to
> know the answer.  I'm assuming that an instance value is not the same
> as a phandle).

ihandles and phandles are not the same thing in OF.  Since in the
"flat world" we cannot have instances, we should use phandles instead
of ihandles for the things in /chosen.  I thought we agreed on that
already, perhaps I am wrong?


Segher
