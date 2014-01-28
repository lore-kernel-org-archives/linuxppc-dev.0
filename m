Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0182.hostedemail.com
 [216.40.44.182]) by ozlabs.org (Postfix) with ESMTP id 6BA332C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 12:57:48 +1100 (EST)
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
 by smtpgrave01.hostedemail.com (Postfix) with ESMTP id E42025D724
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 01:52:44 +0000 (UTC)
Message-ID: <1390873957.20150.78.camel@joe-AO722>
Subject: Re: [PATCH 1/1] Fixed some coding style problems
From: Joe Perches <joe@perches.com>
To: Brandon Stewart <stewartb2@gmail.com>
Date: Mon, 27 Jan 2014 17:52:37 -0800
In-Reply-To: <1390873397-4470-1-git-send-email-stewartb2@gmail.com>
References: <1390873397-4470-1-git-send-email-stewartb2@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-01-27 at 19:43 -0600, Brandon Stewart wrote:
[]
> diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
[]
> @@ -624,8 +623,7 @@ do_adb_query(struct adb_request *req)
>  {
>  	int	ret = -EINVAL;
>  
> -	switch(req->data[1])
> -	{
> +	switch(req->data[1]) {

	switch (req->data[1]) {

> @@ -794,8 +792,8 @@ static ssize_t adb_write(struct file *file, const char __user *buf,
>  	}
>  	/* Special case for ADB_BUSRESET request, all others are sent to
>  	   the controller */
> -	else if ((req->data[0] == ADB_PACKET)&&(count > 1)
> -		&&(req->data[1] == ADB_BUSRESET)) {
> +	else if ((req->data[0] == ADB_PACKET) && (count > 1)
> +		&& (req->data[1] == ADB_BUSRESET)) {

	else if (req->data[0] == ADB_PACKET &&
		 req->data[1] == ADB_BUSRESET &&
		 count > 1) {
