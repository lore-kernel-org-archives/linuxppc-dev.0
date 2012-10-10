Return-Path: <michael@ellerman.id.au>
Message-ID: <1349830831.14090.2.camel@concordia>
Subject: Re: [PATCH 06/20] powerpc/xmon: Remove renaming #defines of
 scanhex() and skipbl()
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
Date: Wed, 10 Oct 2012 12:00:31 +1100
In-Reply-To: <20121009221513.GA21291@bloggs.ozlabs.ibm.com>
References: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
 <1349792447-15714-6-git-send-email-michael@ellerman.id.au>
 <20121009221513.GA21291@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-10-10 at 09:15 +1100, Paul Mackerras wrote:
> On Wed, Oct 10, 2012 at 01:20:33AM +1100, Michael Ellerman wrote:
> > We have two #defines that rename scanhex() and skipbl() to
> > xmon_scanhex() and xmon_skipbl() - but no one ever uses those
> > names.
> > 
> > So the only effect is to rename the actual symbols in the generated
> > code, and AFACIS there is no reason to do that, so drop them.
> 
> You might as well make scanhex() and skipbl() static while you're at
> it.

Actually I was hoping to move the spu code that uses them into a
separate file, so I'll leave them for now.

cheers
