Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 071E6B6FC8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jun 2011 00:08:29 +1000 (EST)
Received: by gyg8 with SMTP id 8so1082304gyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 07:08:25 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <201106171553.06443.dargaud@lpsc.in2p3.fr>
References: <201106171119.48178.dargaud@lpsc.in2p3.fr>
	<4DFB4F51.1090509@gate-nine.de> <4DFB516C.4060602@gate-nine.de>
	<201106171553.06443.dargaud@lpsc.in2p3.fr>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 17 Jun 2011 08:08:05 -0600
Message-ID: <BANLkTi=uDe3WevxtnW8ns3ixMET7tbHzeQ@mail.gmail.com>
Subject: Re: Changes to of_device ?
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 17, 2011 at 7:53 AM, Guillaume Dargaud
<dargaud@lpsc.in2p3.fr> wrote:
>> I'm sorry, I should have mentioned that struct of_device was replaced by
>> struct platform_device. So in order to get your code compiled, you have
>> to change the probe function to
>>
>> static int xad_driver_probe(struct platform_device* dev, const struct
>> of_device_id *match) {
>
> Thanks, that worked...
>
> Side question: how do you guy find your way inside the kernel ? I spent hours trying to find the declarations of various
> basic structs like device, of_node, etc even with ack-grep and ctags (which I probably don't know how to use very well).

For finding structures, the following pattern tends to work well:

git grep 'struct device_node {'

I used to use cscope (make cscope in the kernel tree), but stopped
because the tags go out of date every time I change branches.

g.
