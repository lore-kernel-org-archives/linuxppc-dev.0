Return-Path: <timur@tabi.org>
Received: from relay03.pair.com (relay03.pair.com [209.68.5.17])
 by ozlabs.org (Postfix) with SMTP id D1E9B2C0209
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 00:07:59 +1000 (EST)
Message-ID: <51DD692B.70909@tabi.org>
Date: Wed, 10 Jul 2013 09:01:15 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Alexander Popov <a13xp0p0v88@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anatolij Gustschin <agust@denx.de>,
 Grant Likely <grant.likely@linaro.org>,
 Rob Herring <rob.herring@calxeda.com>, Chris Ball <cjb@laptop.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [V2 2/2] powerpc/512x: add LocalPlus Bus FIFO device driver
References: <1373451678-20065-1-git-send-email-a13xp0p0v88@gmail.com>
 <20130710134624.GC2615@book.gsilab.sittig.org>
In-Reply-To: <20130710134624.GC2615@book.gsilab.sittig.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gerhard Sittig wrote:
>> >+ * Author is Alexander Popov<a13xp0p0v88@gmail.com>.

> nit pick:  is 1337 speak usual and appropriate here?

Um, that's his actual email address.

> shouldn't headers get sorted alphabetically?

Is that a new policy?  I've never heard that requirement.

>> +MODULE_AUTHOR("Alexander Popov <a13xp0p0v88@gmail.com>");
>> +MODULE_DESCRIPTION("MPC512x LocalPlus FIFO device driver");
>> +MODULE_LICENSE("GPL");
>
> aren't these usually at the end of the source for quick lookup?

Yes, and it should be "GPL v2" also.

-- 
Timur Tabi
