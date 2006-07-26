Return-Path: <kallepokki@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id 7375A67B5A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jul 2006 19:53:42 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c2so566185nfe
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jul 2006 02:53:41 -0700 (PDT)
Message-ID: <a425f86c0607260252q180c1af5y2afca9f644142c6a@mail.gmail.com>
Date: Wed, 26 Jul 2006 12:52:00 +0300
From: "Kalle Pokki" <kalle.pokki@iki.fi>
Sender: kallepokki@gmail.com
To: "Edward Jubenville" <edjubenville@adelphia.net>
Subject: Re: Slow boot with NFS, server not responding
In-Reply-To: <GPECLCIGPLHEOMGPMCPAOEIIDNAA.edjubenville@adelphia.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_218914_27132372.1153907520232"
References: <GPECLCIGPLHEOMGPMCPAOEIIDNAA.edjubenville@adelphia.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_218914_27132372.1153907520232
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 7/25/06, Edward Jubenville <edjubenville@adelphia.net> wrote:

I am having trouble booting the kernel with a root file system over NFS.
> Once the kernel has mounted the file system, it cycles through this pair
> of
> messages, endlessly:
>
>         nfs: server 192.168.0.39 not responding, still trying
>         nfs: server 192.168.0.39 OK


Try connecting to an old half-duplex hub instead of a full-duplex switch to
see if it works. Perhaps the duplex setting is not consistent between the
network driver and PHY.

I have a board with exactly the same symptoms, but I've not yet had the time
to look into this. However using the old hub provided a temporary "fix"...

------=_Part_218914_27132372.1153907520232
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 7/25/06, <b class="gmail_sendername">Edward Jubenville</b> &lt;<a href="mailto:edjubenville@adelphia.net">edjubenville@adelphia.net</a>&gt; wrote:<div><span class="gmail_quote"></span><div><br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I am having trouble booting the kernel with a root file system over NFS.<br>
Once the kernel has mounted the file system, it cycles through this pair of<br>messages, endlessly:<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nfs: server <a href="http://192.168.0.39">192.168.0.39</a> not responding, still trying<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nfs: server 
<a href="http://192.168.0.39">192.168.0.39</a> OK</blockquote><div><br>
Try connecting to an old half-duplex hub instead of a full-duplex
switch to see if it works. Perhaps the duplex setting is not consistent
between the network driver and PHY.<br>
<br>
I have a board with exactly the same symptoms, but I've not yet had the
time to look into this. However using the old hub provided a temporary
&quot;fix&quot;...<br>
<br>
</div><br></div><br>

------=_Part_218914_27132372.1153907520232--
