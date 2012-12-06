Return-Path: <michael@ellerman.id.au>
In-Reply-To: <1354777104.9974.5.camel@concordia>
References: <30738.1321497066@neuling.org> <1354777104.9974.5.camel@concordia>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----T91RPUV2SFOEFSGH7GC9ZMBXQ0MJW0"
Subject: Re: [stable] [PATCH] powerpc/ptrace: Fix build with gcc 4.6
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 06 Dec 2012 20:16:53 +1100
To: Michael Neuling <mikey@neuling.org>
Message-ID: <590d39dc-f4d2-49cb-83cb-b3b75dab3de9@email.android.com>
Cc: linuxppc-dev@ozlabs.org, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------T91RPUV2SFOEFSGH7GC9ZMBXQ0MJW0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit



Michael Ellerman <michael@ellerman.id.au> wrote:

>On Thu, 2011-11-17 at 13:31 +1100, Michael Neuling wrote:
>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> 
>> powerpc/ptrace: Fix build with gcc 4.6
>> 
>> gcc (rightfully) complains that we are accessing beyond the
>> end of the fpr array (we do, to access the fpscr).
>
>This patch is still missing from the 3.0 stable series.
>
>Do we need to resend ?

And resent to the correct stable address.

cheers

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
------T91RPUV2SFOEFSGH7GC9ZMBXQ0MJW0
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head/><body><html><head></head><body><br><br><div class="gmail_quote">Michael Ellerman &lt;michael@ellerman.id.au&gt; wrote:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre style="white-space: pre-wrap; word-wrap:break-word; font-family: monospace; margin-top: 0px">On Thu, 2011-11-17 at 13:31 +1100, Michael Neuling wrote:<br /><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #729fcf; padding-left: 1ex;">From: Benjamin Herrenschmidt &lt;benh@kernel.crashing.org&gt;<br /><br />powerpc/ptrace: Fix build with gcc 4.6<br /><br />gcc (rightfully) complains that we are accessing beyond the<br />end of the fpr array (we do, to access the fpscr).</blockquote><br />This patch is still missing from the 3.0 stable series.<br /><br />Do we need to resend ?<br /><br />cheers<br /><br /></pre></blockquote></div><br>
-- <br>
Sent from my Android phone with K-9 Mail. Please excuse my brevity.</body></html></body></html>
------T91RPUV2SFOEFSGH7GC9ZMBXQ0MJW0--
