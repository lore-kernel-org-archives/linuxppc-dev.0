Date: Fri, 7 Mar 2003 11:52:02 -0600
From: Nathan Ingersoll <ningerso@ruralcenter.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Runtime Altivec detection
Message-ID: <20030307175201.GA6252@ruralcenter.org>
References: <20030307164753.GA5240@ruralcenter.org> <3E68D5BF.1050906@embeddededge.com> <1047058865.12206.44.camel@zion.wanadoo.fr>
Mime-Version: 1.0
In-Reply-To: <1047058865.12206.44.camel@zion.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 07, 2003 at 06:41:05PM +0100, Benjamin Herrenschmidt wrote:
>
> There's a much better way. The kernel passes down CPU features
> bits down to userland via ELF AUX tables.

Do you know of any reference code for accessing that information?

Thanks,
Nathan

--
------------------------------------------------------------------------
| Nathan Ingersoll           \\ Computer Systems & Network Coordinator |
| ningerso@ruralcenter.org    \\ http://www.ruralcenter.org            |
| http://ningerso.atmos.org/   \\ Minnesota Center for Rural Health    |
------------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
