Date: Wed, 28 Apr 2004 15:18:10 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Brian Hawley <bhawley@luminex.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ebony PPC440GP & linux 2.6.3
Message-ID: <20040428221810.GA18371@gate.ebshome.net>
References: <5.0.2.1.2.20040428124651.035cbd98@bhawley.mailhost.luminex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.0.2.1.2.20040428124651.035cbd98@bhawley.mailhost.luminex.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 28, 2004 at 12:48:21PM -0700, Brian Hawley wrote:
> It is clear from the archives that people have gotten the Ebony 440GP
> working with linux.
>
> We are using the linux 2.6.3 kernel, and have had little luck getting it
> booted up.
>
> We are using u-boot as the boot loader to load the zImage.
>
> It decompresses the kernel, and says it transfers control, but then just
> stops.
>
> Any suggestions or directions would be most helpful and appreciated.
>

Try newer kernel, e.g. 2.6.5, there were some bugs in previous versions.

Also, does it boot with standard IBM boot loader?

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
