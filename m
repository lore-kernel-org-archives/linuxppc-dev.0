Date: Fri, 12 Mar 2004 15:32:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Caching in the MPC107, linux 2.6
Message-ID: <20040312223250.GE14472@smtp.west.cox.net>
References: <1079088369.691.43.camel@newt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1079088369.691.43.camel@newt>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Mar 12, 2004 at 10:46:09AM +0000, Adrian Cox wrote:

>
> I discovered this problem back in 2002:
>
> http://lists.linuxppc.org/results.html?words=caching+mpc107&method=and&sort=score&restrict=linuxppc-embedded
>
> The 2.6 kernel requires a fix to use a MPC745x along with a MPC107
> bridge. My proposed patch is below - any comments?
>
> Without this fix or something like it my boards cannot use pcnet32
> ethernet.

And this is a rev of the mpc107 which is supposed to work with the 745x
line ?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
