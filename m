Return-Path: <ebs@ebshome.net>
Date: Tue, 26 Sep 2006 09:37:35 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Iwan Koenig <iwankoenig@yahoo.de>
Subject: Re: Asterisk on Embedded Linux
Message-ID: <20060926163735.GA31839@gate.ebshome.net>
References: <20060926064451.71706.qmail@web26012.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060926064451.71706.qmail@web26012.mail.ukl.yahoo.com>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 26, 2006 at 08:44:51AM +0200, Iwan Koenig wrote:
> Does anyone known how to compile Asterisk for a
> powerpc-processor?
> I have tryed:
> ./configure --target=powerpc-linux
> --host=powerpc-604-linux-gnu --prefix=/opt/packages
> And it gives following error:
>  /root/pwlib/include/ptlib.h... configure: error:
> cannot check for file existence when cross compiling
> 
> Ok! I see that it is trying to find the PWLIB-Library.
> Also, i have tryed to compile the pwlib.
> But it didn't work :(. For PWLIB i need the OpenLDAP,
> and when i have compiled the OpenLDAP, than needs
> PWLIB other packages.......
> Also, have anyone ideas, how to compile Asterisk f?r a
> powerpc-processor with another way?
> 

Usually, a lot of open-source software isn't cross-compile friendly. 
The easiest way to actually build such stuff is to do a native build - 
yes, this will be slow, but you'll probably spend more time fixing 
makefiles and scripts (and will likely just gave up on this).

-- 
Eugene
