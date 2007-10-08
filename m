Return-Path: <ralferoo@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.234])
	by ozlabs.org (Postfix) with ESMTP id 32DBADDF93
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 00:00:44 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so1190972wxd
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Oct 2007 07:00:44 -0700 (PDT)
Message-ID: <18a15270710080700m514b49f6p7dc9cf6c8f80d6a6@mail.gmail.com>
Date: Mon, 8 Oct 2007 15:00:43 +0100
From: "Ranulf Doswell" <ralf@ranulf.net>
Sender: ralferoo@gmail.com
To: "geoffrey.levand@am.sony.com" <geoffrey.levand@am.sony.com>
Subject: Re: [patch 2/6] PS3: Remove unused os-area params
In-Reply-To: <20071006213542.595771597@am.sony.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1231_12976460.1191852043992"
References: <20071006213542.311447584@am.sony.com>
	<20071006213542.595771597@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_1231_12976460.1191852043992
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 06/10/2007, geoffrey.levand@am.sony.com <geoffrey.levand@am.sony.com>
wrote:

> struct saved_params {
>-	/* param 0 */
> 	s64 rtc_diff;
> 	unsigned int av_multi_out;
>-	unsigned int ctrl_button;
>-	/* param 1 */
>-	u8 static_ip_addr[4];
>-	u8 network_mask[4];
>-	u8 default_gateway[4];
>-	/* param 2 */
>-	u8 dns_primary[4];
>-	u8 dns_secondary[4];
> } static saved_params;

As these values are correctly populated by the hypervisor from the
preferences on the standard PS3 OS, it is incredibly useful to have this
information available.

Whilst none of the current 'popular' distributions use these fields, I am
currently in the process of making a bootable CD image that does use them in
order to initialise the network. Not having this information available means
that the only sensible option is to use DHCP, which may well not be
available in every case.

Please can we have these fields back? They don't actually take up all that
much room, yet they are incredibly useful.

-- 
Ranulf Doswell

One of the major reasons for the downfall of the Roman Empire was, lacking
zero, they had no way to indicate termination of their C strings.

------=_Part_1231_12976460.1191852043992
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 06/10/2007, <b class="gmail_sendername"><a href="mailto:geoffrey.levand@am.sony.com">geoffrey.levand@am.sony.com</a></b> &lt;<a href="mailto:geoffrey.levand@am.sony.com">geoffrey.levand@am.sony.com</a>&gt; wrote:<br><pre>
&gt; struct saved_params {<br>&gt;-	/* param 0 */<br>&gt; 	s64 rtc_diff;<br>&gt; 	unsigned int av_multi_out;<br>&gt;-	unsigned int ctrl_button;<br>&gt;-	/* param 1 */<br>&gt;-	u8 static_ip_addr[4];<br>&gt;-	u8 network_mask[4];
<br>&gt;-	u8 default_gateway[4];<br>&gt;-	/* param 2 */<br>&gt;-	u8 dns_primary[4];<br>&gt;-	u8 dns_secondary[4];<br>&gt; } static saved_params;<br></pre>As these values are correctly populated by the hypervisor from the preferences on the standard PS3 OS, it is incredibly useful to have this information available.
<br><br>Whilst none of the current &#39;popular&#39; distributions use these fields, I am currently in the process of making a bootable CD image that does use them in order to initialise the network. Not having this information available means that the only sensible option is to use DHCP, which may well not be available in every case.
<br><br>Please can we have these fields back? They don&#39;t actually take up all that much room, yet they are incredibly useful.<br clear="all"><br>-- <br>Ranulf Doswell<br><br>One of the major reasons for the downfall of the Roman Empire was, lacking zero, they had no way to indicate termination of their C strings.

------=_Part_1231_12976460.1191852043992--
