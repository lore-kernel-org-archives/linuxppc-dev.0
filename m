Return-Path: <pnasrat@redhat.com>
Subject: Re: [PATCH] yaboot: enable boot from iscsi target via ethernet
	devices on js20.
From: Paul Nasrat <pnasrat@redhat.com>
To: Doug Maxey <dwm@austin.ibm.com>
In-Reply-To: <200606012056.k51KuUOP008931@falcon10.austin.ibm.com>
References: <200604280605.k3S65tjv012348@bebe.enoyolf.org>
	<200606012056.k51KuUOP008931@falcon10.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 10:46:38 -0400
Message-Id: <1150123598.30925.9.camel@enki.eridu>
Mime-Version: 1.0
Cc: yaboot-devel@ozlabs.org, Linux PowerPC List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-06-01 at 15:56 -0500, Doug Maxey wrote:
> On Tue, 16 May 2006 15:40:30 CDT, Doug Maxey wrote:

> >>Is the , always guaranteed to be there - eg if I have boot
> >>eth1:iscsi,ISCSIARGS  won't this check fail.
> >
> >Yes, with the above command line this would fail. 
> >
> >My point of reference are the bindings that we cannot yet talk about 
> >here, yet.  The device args would always be followed by a comma.  I suppose 
> >that we could just reference the string "iscsi", but then some wag 
> >would want to create some other property that included "iscsi" as a 
> >substring.  Maybe append a comma?
> 
> Any preferences on this?  

Both are kind of messy

> I have another, more radical solution.  
> 
> Adding a parser that understands the full device path and that can 
> return the elements neatly packaged.  Film at 11. 

This sounds to be the better way to do things - and is probably more
generally useful for other node types. Do you have any ideas on this?

Paul
