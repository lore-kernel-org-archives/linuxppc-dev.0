Return-Path: <anton@ozlabs.org>
Date: Tue, 20 Mar 2007 21:05:01 -0500
From: Anton Blanchard <anton@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [patch 10/10] Make sure we only enable xmon once
Message-ID: <20070321020501.GB24496@kryten>
References: <20070321013810.404636000@samba.org>
	<20070321013825.735752000@samba.org>
	<20070321021149.GA2564@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070321021149.GA2564@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > +#ifdef CONFIG_XMON_DEFAULT
> > +int __initdata xmon_on = 1;
> > +#else
> > +int __initdata xmon_on = 0;
> > +#endif
> 
> This shouldn't be __initdata, should it? It's used at runtime below.

Thanks for spotting! New patch on the way.

Anton
