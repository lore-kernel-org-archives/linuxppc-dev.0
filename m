Subject: Re: reading block of data from host problem!!!!
From: Gary Thomas <gary@mlbassoc.com>
To: Anand Franklin J <franklin@innomedia.soft.net>
Cc: Felix Domke <tmbinc@elitedvb.net>,
	ppc_embedded_maillist <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3E66DA14.C200EDC6@innomedia.soft.net>
References: <3E65B5EE.4C2A7459@innomedia.soft.net>
	<3E66A53E.9080608@elitedvb.net>  <3E66DA14.C200EDC6@innomedia.soft.net>
Content-Type: text/plain
Date: 06 Mar 2003 06:47:10 -0700
Message-Id: <1046958431.7159.2916.camel@hermes.chez-thomas.org>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2003-03-05 at 22:18, Anand Franklin J wrote:
>
> Hi Felix
>     the tftp server is working. "tftp localhost" with get zImage.treeboot
> for localhost is working. still the problem exist. I don't what is the
> problem.
> thanking you
> franklin
>

Perhaps your target board is being blocked access to the TFTP server?
Depending on your host, there may be a number of layers where this
can occur.  For example, with a Linux host:
  * Firewall which prevents TFTP requests from being allowed in
  * /etc/hosts.{allow,deny} may need to be set up to allow outside hosts
Others may exist, depending on your host situation.

Now that you know that TFTP is working, at least locally, try it from
a different client (other than your target board).  If this works, it's
possibly a problem with the board (but could still be setup).  If it
does not work, then check the various logs (/var/log/{messages,secure}
and others) to see why.

--
------------------------------------------------------------
Gary Thomas                 |
MLB Associates              |  Consulting for the
+1 (970) 229-1963           |    Embedded world
http://www.mlbassoc.com/    |
email: <gary@mlbassoc.com>  |
gpg: http://www.chez-thomas.org/gary/gpg_key.asc
------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
