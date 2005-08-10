Return-Path: <dan@embeddededge.com>
In-Reply-To: <c237b7e878e0c32f421209fa37b7a156@freescale.com>
References: <c237b7e878e0c32f421209fa37b7a156@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <22fac6c20e1ee142606e4295722c2d1d@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 10 Aug 2005 13:01:34 -0400
To: Becky Bruce <becky.bruce@freescale.com>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: RFC: proposed arch/powerpc directory structure
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 10, 2005, at 12:45 PM, Becky Bruce wrote:

> ....  Listed below are the proposed directories, along with a 
> description of the logical contents, as well as a description of which 
> existing files will be moved into these directories.

I think this is fine, but I'd like to make a suggestion about the file 
names themselves.
Since we have platform directories for a specific processor type or 
core, can we
change the file names a little?  For example, if I'm in the 
platforms/82xx directory,
I don't need to prepend every file with mpc82xx_ or ppc82xx- or 
whatever.  We
know that's what it is, let's try to use the file names to be more 
descriptive of what's
inside of them.  Regardless of the build or management tools we use, I 
still find it
nice to keep a concise file name that is still descriptive, and take 
advantage of
the directory structure names to assist with this.

Thanks.


	-- Dan
