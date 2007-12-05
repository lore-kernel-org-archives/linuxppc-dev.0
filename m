Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Generate useful error message for properties after subnodes 
In-Reply-To: Your message of "Wed, 05 Dec 2007 10:27:04 +1100."
	<20071204232704.GD9487@localhost.localdomain>
References: <20071204232704.GD9487@localhost.localdomain> 
Date: Wed, 05 Dec 2007 08:41:04 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IzvQv-0005aQ-0r@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> On several occasions, I've accidentally put properties after subnodes
> in a dts file.  I've then spent ages thinking that the resulting
> syntax error was because of something else.
> 
> This patch arranges for this specific syntax error to generate a more
> specific and useful error message.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
