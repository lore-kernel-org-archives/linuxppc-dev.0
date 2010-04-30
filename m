Return-Path: <glikely@secretlab.ca>
Received: from mail-qy0-f175.google.com (mail-qy0-f175.google.com
	[209.85.221.175]) by ozlabs.org (Postfix) with ESMTP id C5684B7D41
	for <linuxppc-dev@ozlabs.org>; Sat,  1 May 2010 03:35:37 +1000 (EST)
Received: by qyk5 with SMTP id 5so492093qyk.3
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 10:35:35 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BDB12FB.5060806@in.ibm.com>
References: <4BDAF376.4030005@in.ibm.com> <4BDB12FB.5060806@in.ibm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 30 Apr 2010 11:35:13 -0600
Message-ID: <n2kfa686aa41004301035p7e15c017u7a1b98389cc1e466@mail.gmail.com>
Subject: Re: -next Apr 30: OOPS during eHEA driver initialization
To: Sachin Sant <sachinp@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 30, 2010 at 11:27 AM, Sachin Sant <sachinp@in.ibm.com> wrote:
> Sachin Sant wrote:
>>
>> With today's next eHEA drivers fails to initialize.
>
> If i revert the following patch eHEA network interface is initialized
> properly.
>
> commit cebfe0b6709abdab997c1a00499d67efa32ee1f0
> drivercore: Add of_match_table to the common device drivers

That is an easy one to fix.  I'll get it updated today and send you the result.

g.
