Date: Fri, 4 Oct 2002 13:10:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>, Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: OCP probe cleanup
Message-ID: <20021004031040.GH1933@zax>
References: <20021003070333.GB6160@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021003070333.GB6160@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 03, 2002 at 05:03:33PM +1000, David Gibson wrote:
>
> This patch streamlines the OCP probe logic slightly, abolishing the
> pointless id paramter to the OCP probe callback, and the equally
> pointless ocp_match_device() with it.

Are there any objections to me committing this - I have more OCP
cleanups on the way.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
