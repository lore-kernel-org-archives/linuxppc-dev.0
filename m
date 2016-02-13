Return-Path: <kda@linux-powerpc.org>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 476F11A00AE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 19:39:40 +1100 (AEDT)
Received: by mail-yw0-x242.google.com with SMTP id q190so5395451ywd.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 00:39:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87wpq9qjhj.fsf@linux.vnet.ibm.com>
References: <1454923241-6681-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160212041457.GE13831@oak.ozlabs.ibm.com>
 <87wpq9qjhj.fsf@linux.vnet.ibm.com>
Date: Sat, 13 Feb 2016 11:39:37 +0300
Message-ID: <CAOJe8K1Aq9AUe=O3cLfwFucjnsu=3wRK97-usD7ohzshy4+egg@mail.gmail.com>
Subject: Re: [PATCH V2 00/29] Book3s abstraction in preparation for new MMU
 model
From: Denis Kirjanov <kda@linux-powerpc.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@ozlabs.org>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/13/16, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
> Paul Mackerras <paulus@ozlabs.org> writes:
>
>> On Mon, Feb 08, 2016 at 02:50:12PM +0530, Aneesh Kumar K.V wrote:
>>> Hello,
>>>
>>> This is a large series, mostly consisting of code movement. No new
>>> features
>>> are done in this series. The changes are done to accomodate the upcoming
>>> new memory
>>> model in future powerpc chips. The details of the new MMU model can be
>>> found at
>>>
>>>  http://ibm.biz/power-isa3 (Needs registration). I am including a summary
>>> of the changes below.

That's not a good idea to put your changes somewhere and
ask people to register to be able to download them. It's just
complicates testing your
big amount of changes.

>>
>> This series doesn't seem to apply against either v4.4 or Linus'
>> current master.  What is this patch against?
>>
>
> The patchset have dependencies against other patcheset posted to the
> list. The best option is to pull the branch mentioned instead of trying to
> apply them individually.
>
> -aneesh
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
