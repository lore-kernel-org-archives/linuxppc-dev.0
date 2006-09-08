Return-Path: <mgreer@mvista.com>
Date: Thu, 7 Sep 2006 18:11:56 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: common flatdevtree code
Message-ID: <20060908011156.GA10971@mag.az.mvista.com>
References: <20060831184020.GA13494@mag.az.mvista.com>
	<17662.17895.852128.729679@cargo.ozlabs.ibm.com>
	<20060907003625.GA15533@mag.az.mvista.com>
	<1157615011.18137.14.camel@diesel>
	<20060907182717.GC4398@mag.az.mvista.com>
	<1157667816.5220.30.camel@basalt.austin.ibm.com>
	<20060908005630.GA9823@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060908005630.GA9823@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 07, 2006 at 05:56:31PM -0700, Mark A. Greer wrote:
> Hollis, Paul,
> 
> I made some more changes that I hope you approve of:
> - Added a hdr to the file to try to make it clear that people should
>   not hack the local copy of the file.
> - Fixed a booboo (typo) in my last patch
> - Change the interface to ft_next() to pass a struct that contains the
>   pointers that it sets up.  Also moved the p_strings & version code
>   from the caller to ft_next().  Now, just pass in a NULL value to the
>   'p' param to start at the top of the tree.
> - Cleaned up the callers to ft_next().  I think its much cleaner now.

Forgot to add:

- Change malloc() call to ft_malloc() to be consistent with the changes
  made to exit() -> ft_exit() and free -> ft_free().

Mark
