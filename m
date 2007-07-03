Return-Path: <tgall.foo@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.181])
	by ozlabs.org (Postfix) with ESMTP id 04B93DDEB7
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 00:47:53 +1000 (EST)
Received: by ik-out-1112.google.com with SMTP id b35so1685124ika
	for <linuxppc-dev@ozlabs.org>; Tue, 03 Jul 2007 07:47:51 -0700 (PDT)
Message-ID: <26d387970707030747u69ee8d2axb79452e5e1b7fa2d@mail.gmail.com>
Date: Tue, 3 Jul 2007 09:47:51 -0500
From: "Tom Gall" <tgall.foo@gmail.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] Schedule removal of arch/ppc
In-Reply-To: <1183469146.3590.7.camel@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_74201_15613164.1183474071417"
References: <1183469146.3590.7.camel@weaponx.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: tgall@gentoo.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_74201_15613164.1183474071417
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

June 2008 is a long time away to let this linger. Why not say by End of the
year 2007?  That should give folks essentially two more 2.6 releases.

Regards,

Tom

On 7/3/07, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
>
> The arch/ppc tree has been in a semi-nebulous "bug fix only" state for a
> few kernel releases now.  The patch below officially declares this as of
> the 2.6.22 kernel release and schedules arch/ppc for removal in June of
> 2008.
>
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>
> ---
> Documentation/feature-removal-schedule.txt |   12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
> --- linux-2.6.orig/Documentation/feature-removal-schedule.txt
> +++ linux-2.6/Documentation/feature-removal-schedule.txt
> @@ -348,3 +348,15 @@ Who:  Tejun Heo <htejun@gmail.com>
>
> ---------------------------
>
> +What: The arch/ppc and include/asm-ppc directories
> +When: Jun 2008
> +Why:  The arch/powerpc tree is the merged architecture for ppc32 and
> ppc64
> +      platforms.  Currently there are efforts underway to port the
> remaining
> +      arch/ppc platforms to the merged tree.  New submissions to the
> arch/ppc
> +      tree have been frozen with the 2.6.22 kernel release and that tree
> will
> +      remain in bug-fix only mode until its scheduled removal.  Platforms
> +      that are not ported by June 2008 will be removed due to the lack of
> an
> +      interested maintainer.
> +Who:  linuxppc-dev@ozlabs.org
> +
> +---------------------------
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

------=_Part_74201_15613164.1183474071417
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

June 2008 is a long time away to let this linger. Why not say by End of the year 2007?&nbsp; That should give folks essentially two more 2.6 releases.<br><br>Regards,<br><br>Tom <br><br><div><span class="gmail_quote">On 7/3/07, 
<b class="gmail_sendername">Josh Boyer</b> &lt;<a href="mailto:jwboyer@linux.vnet.ibm.com">jwboyer@linux.vnet.ibm.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
The arch/ppc tree has been in a semi-nebulous &quot;bug fix only&quot; state for a<br>few kernel releases now.&nbsp;&nbsp;The patch below officially declares this as of<br>the 2.6.22 kernel release and schedules arch/ppc for removal in June of
<br>2008.<br><br>Signed-off-by: Josh Boyer &lt;<a href="mailto:jwboyer@linux.vnet.ibm.com">jwboyer@linux.vnet.ibm.com</a>&gt;<br><br>---<br> Documentation/feature-removal-schedule.txt |&nbsp;&nbsp; 12 ++++++++++++<br> 1 file changed, 12 insertions(+)
<br><br>--- linux-2.6.orig/Documentation/feature-removal-schedule.txt<br>+++ linux-2.6/Documentation/feature-removal-schedule.txt<br>@@ -348,3 +348,15 @@ Who:&nbsp;&nbsp;Tejun Heo &lt;<a href="mailto:htejun@gmail.com">htejun@gmail.com
</a>&gt;<br><br> ---------------------------<br><br>+What: The arch/ppc and include/asm-ppc directories<br>+When: Jun 2008<br>+Why:&nbsp;&nbsp;The arch/powerpc tree is the merged architecture for ppc32 and ppc64<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;platforms.&nbsp;&nbsp;Currently there are efforts underway to port the remaining
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch/ppc platforms to the merged tree.&nbsp;&nbsp;New submissions to the arch/ppc<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tree have been frozen with the 2.6.22 kernel release and that tree will<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;remain in bug-fix only mode until its scheduled removal.&nbsp;&nbsp;Platforms
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;that are not ported by June 2008 will be removed due to the lack of an<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interested maintainer.<br>+Who:&nbsp;&nbsp;<a href="mailto:linuxppc-dev@ozlabs.org">linuxppc-dev@ozlabs.org</a><br>+<br>+---------------------------
<br><br>_______________________________________________<br>Linuxppc-dev mailing list<br><a href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.org/mailman/listinfo/linuxppc-dev
</a><br></blockquote></div><br>

------=_Part_74201_15613164.1183474071417--
