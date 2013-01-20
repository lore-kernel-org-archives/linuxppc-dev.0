Return-Path: <paul.gortmaker@gmail.com>
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <20130117223343.GC32446@animalcreek.com>
References: <20130117223343.GC32446@animalcreek.com>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sat, 19 Jan 2013 20:59:18 -0500
Message-ID: <CAP=VYLpyJZ3BYW6xrJOivQoXv3y7msiB5g7_puFw04UdMFW3zA@mail.gmail.com>
Subject: Re: Anyone have a PrPmc 280/2800 handy?
To: "Mark A. Greer" <mgreer@animalcreek.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 17, 2013 at 5:33 PM, Mark A. Greer <mgreer@animalcreek.com> wrote:
> Hello.
>
> I want to make some fixups to the marvell hostbridge and
> mpsc code and would like to test them on a PrPmc280/2800.
> The problem is, I don't have one anymore.

Hi Mark,

Is there another platform that uses mpsc that can be used for
testing?  I ask because I did spend a lot of time with PrPMC-280
and motload/powerboot; some standalone, some on ATCA-F101.
And with that hindsight, I can't help thinking that the right thing
to do some eight years later is to simply consider removing the
support for these old platforms.  Would that make your validation
easier?  If so, then I'd recommend it.  This is of course, just my opinion.

Paul.
--

>
> If you have one handy and don't mind running a quick boot
> test for me,  please let me know.
>
> Thanks,
>
> Mark
> --
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
