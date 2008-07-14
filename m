Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Run relevant checks on dtb input as well as dts 
In-reply-to: <20080707011913.GE6267@yookeroo.seuss> 
References: <20080707011913.GE6267@yookeroo.seuss>
Date: Mon, 14 Jul 2008 14:01:46 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KITIw-0006t8-0U@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch adjusts the testsuite to run most of the tests for the tree
> checking code on input in dtb form as well as dts form.  Some checks
> which only make sense for dts input (like reference handling) are
> excluded, as are those which currently take dtb input because they
> rely on things which cannot be lexically constructed in a dts file.
> 
> This shows up two small bugs in dtc, which are also corrected.
> 
> First, the name_properties test which was is supposed to remove
> correctly formed 'name' properties (because they can be reconstructed
> from tne node name) was instead removing 'name' properties even if
> they weren't correct.
> 
> Secondly, when using dtb or fs input, the runtime tree in dtc did not
> have the parent pointer initialized propertly because.built
> internally.  The appropriate initialization is added to the
> add_child() function.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
