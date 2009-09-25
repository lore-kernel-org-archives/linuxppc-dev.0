Return-Path: <yfrolov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id E9E50B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Sep 2009 19:39:42 +1000 (EST)
Message-ID: <4ABC8FDB.2000502@ru.mvista.com>
Date: Fri, 25 Sep 2009 13:39:39 +0400
From: Yuri Frolov <yfrolov@ru.mvista.com>
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [patch] powerpc: build modules outside the kernel tree fails,
	if it was built using O=
References: <4ABB57CB.3000409@ru.mvista.com>
	<1253841141.7103.489.camel@pasglop>
	<20090925043902.GA2484@merkur.ravnborg.org>
In-Reply-To: <20090925043902.GA2484@merkur.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	rep.dot.nop@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/25/2009 08:39 AM, Sam Ravnborg wrote:
> On Fri, Sep 25, 2009 at 11:12:21AM +1000, Benjamin Herrenschmidt wrote:
>> On Thu, 2009-09-24 at 15:28 +0400, Yuri Frolov wrote:
>>> Hello,
>>>
>>> here is a corresponding bug: http://bugzilla.kernel.org/show_bug.cgi?id=11143
>>> This patch should correctly export crtsavres.o in order to make O= option working.
>>> Please, consider to apply.
>>>
>>>
>>> Fix linking modules against crtsavres.o
>> Hi !
>>
>> This is the same patch you already posted as "
>>
>>
>> [PATCH] Fix linking modules against
>> crtsavres.o
>> "
>>
>> Or it's an update ?

It's the same, sorry for not mentioning it. The previous letter contains attachment crap, so I sent the letter with patch in-lined.

>>
>> I've asked Sam to review it already since it affects the main kernel
>> makefiles, waiting for his answer.
> Saw the duplicates. Will get back to it tonight (morning here now).
> 
> 	Sam
Ok, thank you.
